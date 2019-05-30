From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/6] vhost: accelerate metadata access
Date: Thu, 30 May 2019 11:07:30 -0700 (PDT)
Message-ID: <20190530.110730.2064393163616673523.davem@davemloft.net>
References: <20190524081218.2502-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190524081218.2502-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: hch@infradead.org, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, linux-mm@kvack.org, jglisse@redhat.com, jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org, christophe.de.dinechin@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 May 2019 04:12:12 -0400

> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling like SMAP. This is done through setup kernel address through
> direct mapping and co-opreate VM management with MMU notifiers.
> 
> Test shows about 23% improvement on TX PPS. TCP_STREAM doesn't see
> obvious improvement.

I'm still waiting for some review from mst.

If I don't see any review soon I will just wipe these changes from
patchwork as it serves no purpose to just let them rot there.

Thank you.
