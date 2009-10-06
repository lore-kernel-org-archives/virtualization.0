From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 6 Oct 2009 12:25:46 +0530
Message-ID: <20091006065546.GA25410@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200910011228.30563.borntraeger@de.ibm.com>
	<20091005140535.GA31333@amit-x200.redhat.com>
	<200910060849.22462.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910060849.22462.borntraeger@de.ibm.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Oct 06 2009 [08:49:22], Christian Borntraeger wrote:
> Am Montag 05 Oktober 2009 16:05:35 schrieb Amit Shah:
> > On (Thu) Oct 01 2009 [12:28:30], Christian Borntraeger wrote:
> > > With the latest git kernel + your patch I sometmes get a completely
> > > frozen console. In the dump there is
> > >
> > >     <3>virtio_console virtio0: output:id 68 is not a head!
> > >
> > > Seems that I can reproduce it with large amounts of output (find / for
> > > example) Without your patch everything is fine.
> > 
> > Hey Christian,
> > 
> > Can you try this patch?
> 
> This version seems to work on s390. Thanks

Great; thanks for the confirmation.

The race I'm seeing could be due to some misconfiguration in qemu then.

		Amit
