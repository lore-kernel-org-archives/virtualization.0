From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 2/3] virtio-balloon: deflate up to oom_pages on OOM
Date: Sun, 22 Oct 2017 19:31:43 +0800
Message-ID: <59EC819F.1080205__28647.1609179445$1508671816$gmane$org@intel.com>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>	<1508500466-21165-3-git-send-email-wei.w.wang@intel.com>	<20171022062119-mutt-send-email-mst@kernel.org>
	<201710221311.FFI17148.VStOJQLHOFFMOF@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201710221311.FFI17148.VStOJQLHOFFMOF@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/22/2017 12:11 PM, Tetsuo Handa wrote:
> Michael S. Tsirkin wrote:
>>> -	num_freed_pages = leak_balloon(vb, oom_pages);
>>> +
>>> +	/* Don't deflate more than the number of inflated pages */
>>> +	while (npages && atomic64_read(&vb->num_pages))
>>> +		npages -= leak_balloon(vb, npages);
> don't we need to abort if leak_balloon() returned 0 for some reason?

I don't think so. Returning 0 should be a normal case when the host tries
to give back some pages to the guest, but there is no pages that have ever
been inflated. For example, right after booting the guest, the host sends a
deflating request to give the guest 1G memory, leak_balloon should return 0,
and guest wouldn't get 1 more G memory.


Best,
Wei
