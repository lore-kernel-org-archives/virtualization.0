From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 0/9] virtio DMA API, yet again
Date: Tue, 16 Feb 2016 21:48:58 -0800
Message-ID: <CALCETrXtcL18QnouuNQavDNPvSSf54KxRviGZC3yJD7jECTqcQ__6413.17755585096$1455688179$gmane$org@mail.gmail.com>
References: <cover.1454477782.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 2, 2016 at 9:46 PM, Andy Lutomirski <luto@kernel.org> wrote:
> This switches virtio to use the DMA API on Xen and if requested by
> module option.

Michael, any update on this?

--Andy
