From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] virtio_ring: need_event api comment fix
Date: Mon, 09 May 2011 15:29:43 +0930
Message-ID: <87y62gfm7k.fsf__38627.82006986$1304922974$gmane$org@rustcorp.com.au>
References: <cover.1304605816.git.mst@redhat.com>
	<c8b6d8a8df4927826d0024fceeb68726c50d0b1a.1304605817.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c8b6d8a8df4927826d0024fceeb68726c50d0b1a.1304605817.git.mst@redhat.com>
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

On Thu, 5 May 2011 18:08:17 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> fix typo in a comment: size -> side
> 
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I could smerge these together for you, but I *really* want benchmarks in
these commit messages.

Thanks,
Rusty.
PS. Was away last week, hence the delay on this...
