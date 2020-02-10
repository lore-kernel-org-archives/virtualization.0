From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Mon, 10 Feb 2020 07:27:25 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E42AD6D@shsmsx102.ccr.corp.intel.com>
References: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
 <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
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
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "tysand@google.com" <tysand@google.com>, "namit@vmware.com" <namit@vmware.com>, "rientjes@google.com" <rientjes@google.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "mhocko@kernel.org" <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday, February 10, 2020 11:57 AM, Tetsuo Handa wrote:
> Then, "node-A's NR_FILE_PAGES is already 0 and node-B's NR_FILE_PAGES is
> not 0, but allocation request which triggered this shrinker wants to allocate
> from only node-A"
> would be confused by this change, for the pagecache pages for allocating
> thread's interested node are already depleted but the balloon cannot shrink
> when it should because the pagecache pages for allocating thread's
> uninterested nodes are not yet depleted.

The existing balloon isn't numa aware. "but the balloon cannot shrink " - even we
let balloon to shrink, it could shrink pages from the uninterested node.

When we have a numa aware balloon, we could further update the shrinker
to check with the per node counter , node_page_state(NR_FILE_PAGES).

> 
> >
> Well, my comment is rather: "Do not try to reserve guest's memory. In other
> words, do not try to maintain balloons on the guest side. Since host would
> be able to cache file data on the host's cache, guests would be able to
> quickly fetch file data from host's cache via normal I/O requests." ;-)

Didn't this one. The discussion was about guest pagecache pages v.s. guest balloon pages.
Why is host's pagecache here?

Best,
Wei
