From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Wed, 10 Oct 2007 16:24:03 +0200
Message-ID: <200710101624.04531.arnd@arndb.de>
References: <20070926063618.956228976@rustcorp.com.au>
	<200710101050.49012.borntraeger@de.ibm.com>
	<5d6222a80710100643w7b02b3a7oa24a076b2bad4f52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80710100643w7b02b3a7oa24a076b2bad4f52@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 10 October 2007, Glauber de Oliveira Costa wrote:
> On 10/10/07, Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> >
> > After thinking about that for a while, is there a special reason the config
> > field is defined as little endian? The only reason I can come up with, is to
> > use virtio for cross platform emulators, lets say a ppc emulates an x86 system
> > with virtio devices instead of real ones.
>
> Not really.
> 
> Some platforms have multi-endianess capabilities. So you may want a
> virtual machine running in a different endianess than the host
> machine.

Since virtio is a rather generic concept, there are other things you
might want to do with them, like routing virtio data over the network
to a machine with different endianess, or actually building hardware
that implements some sort of virtio compatible interface.

	Arnd <><
