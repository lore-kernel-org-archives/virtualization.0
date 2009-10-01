From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 1 Oct 2009 19:20:20 +0530
Message-ID: <20091001135020.GA14186__26594.2066944719$1254405258$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200910011228.30563.borntraeger@de.ibm.com>
	<20091001114244.GB12334@amit-x200.redhat.com>
	<200910011404.37601.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910011404.37601.borntraeger@de.ibm.com>
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
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Oct 01 2009 [14:04:37], Christian Borntraeger wrote:
> Am Donnerstag 01 Oktober 2009 13:58:01 schrieben Sie:
> > I spawned two ports; one doing 'find /' and the other transferring a
> > 800M file from the host to the guest, both running at the same time.
> > This is on top of the latest Linus tree + my patches. It works fine.
> > 
> > Can you give me any additional info that can help me nail this down?
> 
> This is just a wild guess: My guest has 8 cpus and virtio requires that users do 
> a proper locking. But as far as I see you use schedule_work which should be 
> single threaded. 
> Or maybe this is an existing bug that is just exposed by your patch - dont know. 

I think there might be two bugs. One is the readbuf_head list needs
some locks around its operations. The readbuf_head list is a per-port
list where buffers received from the host for a port are stored.
They're taken off that list when userspace issues read() requests.

The other bug is the virtio one that you saw. I'll try to see how that
one gets triggered.

Thanks,
		Amit
