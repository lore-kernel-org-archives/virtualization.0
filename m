From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/3] virtio_console: use virtqueue notification for
	hvc_console
Date: Tue, 3 Jun 2008 19:24:41 +0200
Message-ID: <200806031924.42464.arnd@arndb.de>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031446.15330.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806031446.15330.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linuxppc-dev@ozlabs.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 June 2008, Christian Borntraeger wrote:
>  
> +/* The hvc device */
> +struct hvc_struct *hvc;
> +

I guess this should be static, a three letter identifier for a global variable
is not really unique.

	Arnd <><
