From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 2/3] Virtio draft II: example block driver
Date: Fri, 08 Jun 2007 11:11:25 +1000
Message-ID: <1181265085.24958.3.camel__33177.2605459721$1181272186$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181217867.14054.195.camel@localhost.localdomain>
	<1181217920.14054.196.camel@localhost.localdomain>
	<4667F7C0.3070604@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4667F7C0.3070604@qumranet.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-06-07 at 15:19 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > +	sprintf(vblk->disk->disk_name, "vb%c", virtblk_index++);
> >   
> 
> vd%c, in keeping with hd%c and sd%c?

Should work, since iSeries' devices are /dev/iseries/vd%c.  Is there
already a magic routine to take the base and assign the a... aaa etc?

Rusty.
