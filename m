From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: bug in virtio network driver?
Date: Tue, 21 Aug 2007 17:06:29 +0200
Message-ID: <200708211706.29676.arnd@arndb.de>
References: <200708211048.33534.borntraeger@de.ibm.com>
	<1187687377.19435.176.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187687377.19435.176.camel@localhost.localdomain>
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
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 21 August 2007, Rusty Russell wrote:
> > One solution would be to use the xmit_done interrupt. Unfortunately t=
his would=20
> > require additional locking as multiple interrupts can happen at two o=
r more=20
> > cpus. Do you have any better ideas?
>=20
> The only reason that we don't do it in skb_xmit_done() is because
> kfree_skb() isn't supposed to be called from an interrupt. =A0But there=
's
> dev_kfree_skb_any() which can be used.

That will simply trigger a softirq, right? If you need the softirq anyway=
,
why not do all the tx handling in the poll() method like other drivers?

	Arnd <><
