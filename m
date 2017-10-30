From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: packed ring layout proposal v3
Date: Mon, 30 Oct 2017 04:08:46 +0200
Message-ID: <20171030040341-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
	<20171025191346-mutt-send-email-mst@kernel.org>
	<AM4PR0501MB2723177BF4E5EE32CC878E8CD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
	<20171029162117-mutt-send-email-mst@kernel.org>
	<AM4PR0501MB272332C92A384C97D6975D8DD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB272332C92A384C97D6975D8DD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
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

On Sun, Oct 29, 2017 at 02:34:56PM +0000, Ilya Lesokhin wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Sunday, October 29, 2017 4:22 PM
> > To: Ilya Lesokhin <ilyal@mellanox.com>
> > Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundation.org
> > Subject: Re: packed ring layout proposal v3
> > 
> > If you do this whats the point of the id? Just use descriptor offset like virtio 0 did.
> > 
> 
> I agree that ID is pointless when requests are completed in order.
> 
> But I'm not sure what you mean by descriptor offset?

Where the descriptor is within the ring.

-- 
MST
