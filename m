From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 02/14] virtio ring: inline function to check for events
Date: Sat, 21 May 2011 11:59:40 +0930
Message-ID: <87y620u6p7.fsf__1384.25568952716$1305945738$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<16ce853af7a80d0f7cb0c1118ba8e19adc184ad0.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <16ce853af7a80d0f7cb0c1118ba8e19adc184ad0.1305846412.git.mst@redhat.com>
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

On Fri, 20 May 2011 02:10:27 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> With the new used_event and avail_event and features, both
> host and guest need similar logic to check whether events are
> enabled, so it helps to put the common code in the header.
> 
> Note that Xen has similar logic for notification hold-off
> in include/xen/interface/io/ring.h with req_event and req_prod
> corresponding to event_idx + 1 and new_idx respectively.
> +1 comes from the fact that req_event and req_prod in Xen start at 1,
> while event index in virtio starts at 0.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied.

Thanks,
Rusty.
