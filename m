From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mem: paravirtualized memory
Date: Mon, 31 Jul 2017 17:12:24 +0300
Message-ID: <20170731162757-mutt-send-email-mst@kernel.org>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<0a7cd2a8-45ff-11d1-ddb5-036ce36af163@redhat.com>
	<CAPcyv4iYdEAv7wqun5L1C-gT7fMDpO+M918or-bg5XiWLnM3=w@mail.gmail.com>
	<d5a1f1d2-f7c8-cacc-3267-ed6f7d2507ca@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d5a1f1d2-f7c8-cacc-3267-ed6f7d2507ca@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Rik van Riel <riel@redhat.com>, KVM <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 28, 2017 at 05:48:07PM +0200, David Hildenbrand wrote:
> In general, a paravirtualized interface (for detection of PMEM regions)
> might have one big advantage: not limited to certain architectures.

What follows is a generic rant, and slightly offtopic -sorry about that.
I thought it's worth replying to above since people sometimes propose
random PV devices and portability is often the argument. I'd claim if
its the only argument - its not a very good one.

One of the points of KVM is to try and reuse the infrastructure in Linux
that runs containers/bare metal anyway.  The more paravirtualized
interfaces you build, the more effort you get to spend to maintain
various aspects of the system. As optimizations force more and more
paravirtualization into the picture, our solution has been to try to
localize their effect, so you can mix and match paravirtualization and
emulation, as well as enable a subset of PV things that makes sense. For
example, virtio devices look more or less like PCI devices on systems
that have PCI.

It's not clear it applies here - memory overcommit on bare metal is
kind of different.

-- 
MST
