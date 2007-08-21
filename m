From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 13:17:56 -0400
Message-ID: <1187716676.4363.365.camel__43462.0659718805$1187716902$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
	<1187704038.19435.194.camel@localhost.localdomain>
	<1187705162.4363.323.camel@ghaskins-t60p.haskins.net>
	<1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
	<46CB1D06.1040005@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46CB1D06.1040005@qumranet.com>
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
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 20:12 +0300, Avi Kivity wrote:

> No, sync() means "make the other side aware that there's work to be done".
> 

Ok, but still the important thing isn't the kick per se, but the
resulting completetion.  Can we do interrupt driven reclamation?  Some
of those virtio_net emails I saw kicking around earlier today implied
buffers are reclaimed on the next xmit (e.g. polling) which violates the
netif rules for avoiding deadlock.  I suppose that could have just been
an implementation decision....but I remember wondering how reaping would
work when virtio first came out.

Regards,
-Greg
