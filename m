From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 04/14] vhost: support event index
Date: Sat, 21 May 2011 12:01:47 +0930
Message-ID: <87sjs8u6lo.fsf__41913.6698161767$1305945745$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<b227febf884dcf82dee9233e581c6216d0e9daa5.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b227febf884dcf82dee9233e581c6216d0e9daa5.1305846412.git.mst@redhat.com>
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

On Fri, 20 May 2011 02:10:54 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Support the new event index feature. When acked,
> utilize it to reduce the # of interrupts sent to the guest.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, even though it'd normally be in your tree, it's easier for me
to push all together.

Thanks,
Rusty.
