From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Thu, 6 Feb 2020 09:44:17 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E42397C@shsmsx102.ccr.corp.intel.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <6ccbfeea-de66-20d7-0e08-a5834a3c3d3f@redhat.com>
 <286AC319A985734F985F78AFA26841F73E4238BA@shsmsx102.ccr.corp.intel.com>
 <80f975c9-5f18-a613-6412-292dafd34dfe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80f975c9-5f18-a613-6412-292dafd34dfe@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "tysand@google.com" <tysand@google.com>, "mst@redhat.com" <mst@redhat.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "namit@vmware.com" <namit@vmware.com>, "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday, February 6, 2020 5:32 PM, David Hildenbrand wrote:
> 
> If the page cache is empty, a drop_slab() will deflate the whole balloon if I
> am not wrong.
> 
> Especially, a echo 3 > /proc/sys/vm/drop_caches
> 
> will first drop the page cache and then drop_slab()

Then that's the problem of "echo 3 > /proc/sys/vm/drop_cache" itself. It invokes other shrinkers as well (if considered an issue), need to be tweaked in the mm.

Best,
Wei
