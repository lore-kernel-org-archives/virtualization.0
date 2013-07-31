From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 9/9] virtio: console: prevent use-after-free of port
	name in port unplug
Date: Wed, 31 Jul 2013 13:40:29 +0530
Message-ID: <20130731081029.GB27354@grmbl.mre>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<83c058bc32c4e377a75235120885aec7dfd223c7.1374759439.git.amit.shah@redhat.com>
	<871u6i6k2e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <871u6i6k2e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 29 Jul 2013 [14:26:09], Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
> > Remove the debugfs path before freeing port->name, to prevent a possible
> > use-after-free.
> >
> > Reported-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> Applied,
> Rusty.

Hey Rusty, I don't see this patch in your virtio-next branch:

https://git.kernel.org/cgit/linux/kernel/git/rusty/linux.git/log/?h=virtio-next

The others are present there.  Looks like this one got missed?

		Amit
