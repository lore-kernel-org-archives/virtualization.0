From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Mon, 10 Feb 2020 03:13:21 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "tysand@google.com" <tysand@google.com>, "namit@vmware.com" <namit@vmware.com>, "rientjes@google.com" <rientjes@google.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday, February 8, 2020 8:33 PM, Tetsuo Handa wrote:
> 
> Is this NUMA aware? Can "node-A's NR_FILE_PAGES is already 0 and
> node-B's NR_FILE_PAGES is not 0, but allocation request which triggered this
> shrinker wants to allocate from only node-B" happen? 

No, it's a global counter.

>Can some thread keep
> this shrinker defunctional by keep increasing NR_FILE_PAGES?

Yes. Actually it's our intention - as long as there are pagecache pages,
balloon pages are avoided to be reclaimed.


> 
> Is this patch from "Re: Balloon pressuring page cache" thread? I hope that
> the guest could start reclaiming memory based on host's request (like OOM
> notifier chain) which is issued when host thinks that host is getting close to
> OOM and thus guests should start returning their unused memory to host.
> Maybe "periodically (e.g. 5 minutes)" in addition to "upon close to OOM
> condition" is also possible.

That's about the host usages. The host side management software decides when to issue a request to balloon (either periodically or event driven), I think there isn't anything we need to do in the balloon driver here.

Best,
Wei
