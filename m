From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: [kvm-devel] [PATCH] virtio_blk: allow read-only disks
Date: Fri, 16 May 2008 11:28:27 +0200
Message-ID: <482D53BB.2030203__28965.4544940733$1211209237$gmane$org@wpkg.org>
References: <200805161117.03439.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805161117.03439.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger schrieb:
> Hello Rusty,
> 
> sometimes it is useful to share a disk (e.g. usr). To avoid file system 
> corruption, the disk should be mounted read-only in that case.

Although it is done at a different level here, I wanted to note that mounting a 
filesystem read-only does not necessarily mean the system will not try to write 
to it. This is the case for ext3, for example - when mounted ro, system will 
still reply the journal and do some writes etc.

The patch, however, should take care of that, too, as it is completely different 
place it is made ro.


-- 
Tomasz Chmielewski
http://wpkg.org
