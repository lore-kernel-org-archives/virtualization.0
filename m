From: Ilya Lesokhin <ilyal@mellanox.com>
Subject: RE: packed ring layout proposal v3
Date: Sun, 8 Oct 2017 06:16:44 +0000
Message-ID: <AM4PR0501MB27236B71E1B02176F1844ACBD4770__40034.4320376918$1507443434$gmane$org@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> > -----Original Message-----
> > From: virtualization-bounces@lists.linux-foundation.org
> > [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf
> > Of Michael S. Tsirkin
> >
> > This is an update from v2 version.
>> ...
> > When driver descriptors are chained in this way, multiple descriptors
> > are treated as a part of a single transaction containing an optional
> > write buffer followed by an optional read buffer.
> > All descriptors in the chain must have the same ID.
> >

I apologize for the repost, I didn't realize I have to be a member of the 
virtio-dev mailing list.

I'm concerned about the "same ID" requirement in chained descriptors.
 
Assuming out of order execution, how is the driver supposed to re-assign
unique IDs to the previously chained descriptor?
Is the driver expected to copy original IDs somewhere else before the
chaining and then restore the IDs after the chain is executed?
 
Thanks,
Ilya
