From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 1 Oct 2009 14:04:37 +0200
Message-ID: <200910011404.37601.borntraeger__32017.5253590152$1254398797$gmane$org@de.ibm.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200910011228.30563.borntraeger@de.ibm.com>
	<20091001114244.GB12334@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091001114244.GB12334@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag 01 Oktober 2009 13:58:01 schrieben Sie:
> I spawned two ports; one doing 'find /' and the other transferring a
> 800M file from the host to the guest, both running at the same time.
> This is on top of the latest Linus tree + my patches. It works fine.
> 
> Can you give me any additional info that can help me nail this down?

This is just a wild guess: My guest has 8 cpus and virtio requires that users do 
a proper locking. But as far as I see you use schedule_work which should be 
single threaded. 
Or maybe this is an existing bug that is just exposed by your patch - dont know. 
