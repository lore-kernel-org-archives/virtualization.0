From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 10:52:27 -0500
Message-ID: <47E2883B.7050108__40481.3301320702$1206028783$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com> <47E26CC1.8080900@codemonkey.ws>
	<47E27461.4090404@qumranet.com> <47E2771A.4060405@codemonkey.ws>
	<47E27AE7.7090503@qumranet.com> <47E27D1E.2090203@codemonkey.ws>
	<47E28482.9010501@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E28482.9010501@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>
> I disagree.  A driver domain is shared between multiple guests, and if 
> one of the guests manages to break into qemu then it can see other 
> guest's data.

You still don't strictly need to do things in the kernel if this is your 
concern.  You can have another process map both guest's address spaces 
and do the copying on behalf of each guest if you're paranoid about 
escaping into QEMU.

> [Driver domains are a horrible idea IMO, but that's another story]

I don't disagree :-)

Regards,

Anthony Liguori
