From: Alon Levy <alevy@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Thu, 4 Nov 2010 11:13:58 +0200
Message-ID: <20101104091358.GA28832@playa.tlv.redhat.com>
References: <1097264455.965471288612409433.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
 <4CCEC090.3050009@codemonkey.ws>
 <4CD1A406.3090909@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CD1A406.3090909@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: Anthony Liguori <anthony@codemonkey.ws>, QEMU Developers <qemu-devel@nongnu.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 03, 2010 at 06:03:50PM +0000, Ian Molton wrote:
> On 01/11/10 13:28, Anthony Liguori wrote:
> >On 11/01/2010 06:53 AM, Alon Levy wrote:
> 
> >>While we (speaking as part of the SPICE developers) want to have the same
> >>support in our virtual GPU for 3d as we have for 2d, we just don't at
> >>this point of time.
> 
> Would it be helpful to you to have /something/ that works in the
> interim? I'm happy to work with you guys so that we dont need to
> reinvent the wheel ;-)
> 

In case it wasn't clear, I think putting virtio-gl is a good idea, exactly because it works right now.

[Snip]
