From: Amit Shah <amitshah@gmx.net>
Subject: Re: [PATCH 5/5] virtio_console: Constify some static variables
Date: Sun, 5 Jul 2020 20:30:38 +0200
Message-ID: <20200703175529.GE3150@trundl.on>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
 <20200701200950.30314-6-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200701200950.30314-6-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 01 Jul 2020 [22:09:50], Rikard Falkeborn wrote:
> The id_table and feature_table pointers in struct virtio_driver are
> pointers to const. Mark the corresponding static variables const to
> allow the compiler to put them in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>   25447     713      76   26236    667c drivers/char/virtio_console.o
> 
> After:
>    text    data     bss     dec     hex filename
>   25488     673      76   26237    667d drivers/char/virtio_console.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Amit Shah <amit@kernel.org>

Please CC me on the entire series instead of individual patches in the
future.

Thanks,

		Amit
-- 
http://amitshah.net/
