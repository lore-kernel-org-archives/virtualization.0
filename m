From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH] virtio_blk: allow read-only disks
Date: Sat, 17 May 2008 14:01:56 +1000
Message-ID: <200805171401.59076.rusty__17549.0084141076$1210997077$gmane$org@rustcorp.com.au>
References: <200805161117.03439.borntraeger@de.ibm.com>
	<482D53BB.2030203@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <482D53BB.2030203@wpkg.org>
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
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: kvm-devel@lists.sourceforge.net, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 16 May 2008 19:28:27 Tomasz Chmielewski wrote:
> Christian Borntraeger schrieb:
> > Hello Rusty,
> >
> > sometimes it is useful to share a disk (e.g. usr). To avoid file system
> > corruption, the disk should be mounted read-only in that case.
>
> Although it is done at a different level here, I wanted to note that
> mounting a filesystem read-only does not necessarily mean the system will
> not try to write to it. This is the case for ext3, for example - when
> mounted ro, system will still reply the journal and do some writes etc.
>
> The patch, however, should take care of that, too, as it is completely
> different place it is made ro.

Note I'm assuming that the host will deny writes.  Telling the guest is merely 
politeness.

Cheers,
Rusty.
