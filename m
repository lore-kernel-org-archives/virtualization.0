From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH v4 13/25] virtio_console: enable VQs early
Date: Mon, 20 Oct 2014 15:44:53 +0100
Message-ID: <20141020144453.GD18561__27962.398765567$1413820938$gmane$org@casper.infradead.org>
References: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
	<1413114332-626-14-git-send-email-mst-v4@redhat.com>
	<20141020120750.GA18561@casper.infradead.org>
	<20141020144223.5655dcbc.cornelia.huck@de.ibm.com>
	<20141020133555.GA27111@redhat.com>
	<20141020140410.GA10994@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141020140410.GA10994@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, wlinux-kernel@vger.kernel.org, netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 10/20/14 at 05:04pm, Michael S. Tsirkin wrote:
> Sure enough, this helps:
> 
> Tested-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Pls repost as a top-level patch.

Thanks for fixing this so promptly.
