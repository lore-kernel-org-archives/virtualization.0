From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Thu, 6 Feb 2020 10:32:20 +0100
Message-ID: <80f975c9-5f18-a613-6412-292dafd34dfe@redhat.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <6ccbfeea-de66-20d7-0e08-a5834a3c3d3f@redhat.com>
 <286AC319A985734F985F78AFA26841F73E4238BA@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E4238BA@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Wei W" <wei.w.wang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "tysand@google.com" <tysand@google.com>, "mst@redhat.com" <mst@redhat.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "namit@vmware.com" <namit@vmware.com>, "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
List-Id: virtualization@lists.linuxfoundation.org

On 06.02.20 10:28, Wang, Wei W wrote:
> On Thursday, February 6, 2020 5:10 PM, David Hildenbrand wrote:
>> so dropping caches (echo 3 > /proc/sys/vm/drop_caches) will no longer
>> deflate the balloon when conservative_shrinker=true?
>>
> 
> Should be. Need Tyler's help to test it.
> 

If the page cache is empty, a drop_slab() will deflate the whole balloon
if I am not wrong.

Especially, a echo 3 > /proc/sys/vm/drop_caches

will first drop the page cache and then drop_slab()

While I like the general idea, it looks more like a hack to me, to try
to teach the shrinker something it was not built for/does not support yet.

-- 
Thanks,

David / dhildenb
