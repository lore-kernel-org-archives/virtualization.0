From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 08:24:07 -0500
Message-ID: <4A93E5F7.5010606__37850.6067827859$1251206709$gmane$org@codemonkey.ws>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A936525.5030300@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> My preference is ring proxying.  Not we'll need ring proxying (or at 
> least event proxying) for non-MSI guests.

Thinking about this more...

How does the hand off work?  Assuming you normally don't proxy ring 
entries and switch to proxying them when you want to migration, do you 
have a set of ioctl()s that changes the semantics of the ring to be host 
virtual addresses instead of guest physical?  If so, what do you do with 
in flight requests?  Does qemu have to buffer new requests and wait for 
old ones to complete?

Unless you always do ring proxying.  If that's the case, we don't need 
any of the slot management code in vhost.

Regards,

Anthony Liguori
