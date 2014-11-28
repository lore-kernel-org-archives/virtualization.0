From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 04/46] virtio: add support for 64 bit features.
Date: Fri, 28 Nov 2014 09:52:26 +0100
Message-ID: <20141128095226.44781a98@thinkpad-w530>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417118789-18231-5-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, Joel Stanley <joel@jms.id.au>, linux390@de.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> Change u32 to u64, and use BIT_ULL and 1ULL everywhere.
> 
> Note: transports are unchanged, and only set low 32 bit.
> This guarantees that no transport sets e.g. VERSION_1
> by mistake without proper support.
> 
> Based on patch by Rusty.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
