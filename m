From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: export virtio_rng.h
Date: Mon, 11 Aug 2008 12:46:05 +1000
Message-ID: <200808111246.05488.rusty__31215.2691687972$1218425759$gmane$org@rustcorp.com.au>
References: <200808081115.07411.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200808081115.07411.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 08 August 2008 19:15:07 Christian Borntraeger wrote:
> Hello Rusty,
>
> The entropy device was added after we exported all virtio headers. This
> patch adds virtio_rng.h to the exportable userspace headers.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks, applied!

Rusty.
