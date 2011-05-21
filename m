From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 03/14] virtio_ring: support event idx feature
Date: Sat, 21 May 2011 12:01:13 +0930
Message-ID: <87vcx4u6mm.fsf__19141.0256702968$1305945519$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<960f3e3b260844011b004c81dbda0661c977b79a.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <960f3e3b260844011b004c81dbda0661c977b79a.1305846412.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 20 May 2011 02:10:44 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Support for the new event idx feature:
> 1. When enabling interrupts, publish the current avail index
>    value to the host to get interrupts on the next update.
> 2. Use the new avail_event feature to reduce the number
>    of exits from the guest.

Applied.

Thanks,
Rusty.
