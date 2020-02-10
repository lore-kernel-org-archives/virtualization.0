From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: RE: [PATCH RFC]
 =?ISO-2022-JP?B?dmlydGlvX2JhbGxvb246IGNvbnNlcnZhdGl2ZSBi?=
 =?ISO-2022-JP?B?YWxsb29uIHBhZ2Ugc2hyaW5raW5n?=
Date: Mon, 10 Feb 2020 12:57:23 +0900
Message-ID: <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
References: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "tysand@google.com" <tysand@google.com>, "namit@vmware.com" <namit@vmware.com>, "rientjes@google.com" <rientjes@google.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "mhocko@kernel.org" <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Wang, Wei W wrote:
> On Saturday, February 8, 2020 8:33 PM, Tetsuo Handa wrote:
> > 
> > Is this NUMA aware? Can "node-A's NR_FILE_PAGES is already 0 and
> > node-B's NR_FILE_PAGES is not 0, but allocation request which triggered this
> > shrinker wants to allocate from only node-B" happen? 
> 
> No, it's a global counter.
> 
> >Can some thread keep
> > this shrinker defunctional by keep increasing NR_FILE_PAGES?
> 
> Yes. Actually it's our intention - as long as there are pagecache pages,
> balloon pages are avoided to be reclaimed.

Then, "node-A's NR_FILE_PAGES is already 0 and node-B's NR_FILE_PAGES is not 0, but
allocation request which triggered this shrinker wants to allocate from only node-A"
would be confused by this change, for the pagecache pages for allocating thread's
interested node are already depleted but the balloon cannot shrink when it should
because the pagecache pages for allocating thread's uninterested nodes are not yet
depleted.

> 
> 
> > 
> > Is this patch from "Re: Balloon pressuring page cache" thread? I hope that
> > the guest could start reclaiming memory based on host's request (like OOM
> > notifier chain) which is issued when host thinks that host is getting close to
> > OOM and thus guests should start returning their unused memory to host.
> > Maybe "periodically (e.g. 5 minutes)" in addition to "upon close to OOM
> > condition" is also possible.
> 
> That's about the host usages. The host side management software decides when to
> issue a request to balloon (either periodically or event driven), I think there
> isn't anything we need to do in the balloon driver here.

Well, my comment is rather: "Do not try to reserve guest's memory. In other words,
do not try to maintain balloons on the guest side. Since host would be able to cache
file data on the host's cache, guests would be able to quickly fetch file data from
host's cache via normal I/O requests." ;-)
