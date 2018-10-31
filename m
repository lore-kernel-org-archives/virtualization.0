From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: Fix Spectre V1 vulnerability
Date: Wed, 31 Oct 2018 12:39:53 -0700 (PDT)
Message-ID: <20181031.123953.2258610601885351617.davem__19187.7778656364$1541014693$gmane$org@davemloft.net>
References: <20181030061049.7424-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181030061049.7424-1-jasowang@redhat.com>
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jpoimboe@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Oct 2018 14:10:49 +0800

> The idx in vhost_vring_ioctl() was controlled by userspace, hence a
> potential exploitation of the Spectre variant 1 vulnerability.
> 
> Fixing this by sanitizing idx before using it to index d->vqs.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
