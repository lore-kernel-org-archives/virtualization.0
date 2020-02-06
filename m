From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Thu, 6 Feb 2020 06:26:35 -0500
Message-ID: <20200206062558-mutt-send-email-mst@kernel.org>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <20200206035749-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E4238A5@shsmsx102.ccr.corp.intel.com>
 <20200206042824-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E42395B@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73E42395B@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "tysand@google.com" <tysand@google.com>, "david@redhat.com" <david@redhat.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "namit@vmware.com" <namit@vmware.com>, "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 06, 2020 at 09:43:10AM +0000, Wang, Wei W wrote:
> On Thursday, February 6, 2020 5:31 PM, Michael S. Tsirkin wrote:
> > 
> > How about just making this a last resort thing to be compatible with existing
> > hypervisors? if someone wants to change behaviour that really should use a
> > feature bit ...
> 
> Yeah, sounds good to me to control via feature bits.
> 
> Best,
> Wei

To clarify, shrinker use could be a feature bit. OOM behaviour was
there for years and has been used to dynamically size guests.

-- 
MST
