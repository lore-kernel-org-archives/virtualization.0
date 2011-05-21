From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 06/14] virtio: add api for delayed callbacks
Date: Sat, 21 May 2011 12:03:35 +0930
Message-ID: <87mxigu6io.fsf__25203.0281154022$1305945394$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<8f343dcaa996f6b10499468c49508ba9d6fb6f5a.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8f343dcaa996f6b10499468c49508ba9d6fb6f5a.1305846412.git.mst@redhat.com>
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

On Fri, 20 May 2011 02:11:14 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Add an API that tells the other side that callbacks
> should be delayed until a lot of work has been done.
> Implement using the new event_idx feature.
> 
> Note: it might seem advantageous to let the drivers
> ask for a callback after a specific capacity has
> been reached. However, as a single head can
> free many entries in the descriptor table,
> we don't really have a clue about capacity
> until get_buf is called. The API is the simplest
> to implement at the moment, we'll see what kind of
> hints drivers can pass when there's more than one
> user of the feature.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Yes, I've applied this (and the next one which uses it in virtio_net),
despite my reservations about the API.  But that is fixable...

Thanks,
Rusty.
