From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v4 00/12] virtio: s4 support
Date: Wed, 7 Dec 2011 13:14:56 +0530
Message-ID: <20111207074456.GD4651@amit-x200.redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<87wra8j13m.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wra8j13m.fsf@rustcorp.com.au>
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
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [17:54:29], Rusty Russell wrote:
> On Wed,  7 Dec 2011 01:18:38 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > Hi,
> > 
> > These patches add support for S4 to virtio (pci) and all drivers.
> 
> Dumb meta-question: why do we want to hibernate virtual machines?

Not a dumb question at all :)

But that doesn't mean I can't give a dumb answer: "Because We Can".

> I figure there's a reason, but it seems a bit weird :)

Well, there is one reason right now: migrating storage along with
VMs.  The guest needs to sync all data to the disk before the target
host accesses the image file.  One way to make sure guests don't access
the disk is by adding a new guest command to stop disk accesses.
However, we already have one way of making guests stop doing whatever
they are by putting them into S4 state, and then waking them up on the
remote, with them thinking nothing about them has changed.

(Did I manage to make this sound desirable after the answer above? :)

	     Amit
