From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 15:41:49 +0800
Message-ID: <597EDF3D.8020101__22049.4988411248$1501486771$gmane$org@intel.com>
References: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
	<20170731065508.GE13036@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170731065508.GE13036@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, zhenwei.pi@youruncloud.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/31/2017 02:55 PM, Michal Hocko wrote:
> On Mon 31-07-17 12:13:33, Wei Wang wrote:
>> Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
>> shouldn't be given to the host ksmd to scan.
> Could you point me where this MADV_DONTNEED is done, please?

Sure. It's done in the hypervisor when the balloon pages are received.

Please see line 40 at
https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c


>
>> Therefore, it is not
>> necessary to zero ballooned pages, which is very time consuming when
>> the page amount is large. The ongoing fast balloon tests show that the
>> time to balloon 7G pages is increased from ~491ms to 2.8 seconds with
>> __GFP_ZERO added. So, this patch removes the flag.
> Please make it obvious that this is a revert of bb01b64cfab7
> ("mm/balloon_compaction.c: enqueue zero page to balloon device").
>
>

Ok, will do.

Best,
Wei
