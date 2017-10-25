From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: packed ring layout proposal v3
Date: Wed, 25 Oct 2017 19:20:01 +0300
Message-ID: <20171025191346-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 08, 2017 at 06:16:44AM +0000, Ilya Lesokhin wrote:
> > > -----Original Message-----
> > > From: virtualization-bounces@lists.linux-foundation.org
> > > [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf
> > > Of Michael S. Tsirkin
> > >
> > > This is an update from v2 version.
> >> ...
> > > When driver descriptors are chained in this way, multiple descriptors
> > > are treated as a part of a single transaction containing an optional
> > > write buffer followed by an optional read buffer.
> > > All descriptors in the chain must have the same ID.
> > >
> 
> I apologize for the repost, I didn't realize I have to be a member of the 
> virtio-dev mailing list.
> 
> I'm concerned about the "same ID" requirement in chained descriptors.

It's there really just so we can remove the doubt about which
descriptor's ID should be used. My testing does not show
a performance win from this, so I'm fine with removing this
requirement though I'd be curious to know why is it a problem.

> Assuming out of order execution, how is the driver supposed to re-assign
> unique IDs to the previously chained descriptor?

For example, driver can have a simple allocator for the IDs.


> Is the driver expected to copy original IDs somewhere else before the
> chaining and then restore the IDs after the chain is executed?
>  
> Thanks,
> Ilya

As device overwrites the ID, driver will have to write it out
each time, that's true. It's going to be a requirement even if
descriptors on the chain do not need to have the same ID.

-- 
MST
