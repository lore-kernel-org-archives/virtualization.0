From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: console: fix error handling in init() function
Date: Mon, 10 Sep 2012 11:49:37 +0930
Message-ID: <87627mfwli.fsf@rustcorp.com.au>
References: <1346528977-23066-1-git-send-email-khoroshilov@ispras.ru>
	<20120909201947.GF16985@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120909201947.GF16985@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: ldv-project@ispras.ru, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Sat) 01 Sep 2012 [23:49:37], Alexey Khoroshilov wrote:
>> If register_virtio_driver() fails, virtio-ports class is not destroyed.
>> The patch adds error handling of register_virtio_driver().
>> 
>> Found by Linux Driver Verification project (linuxtesting.org).
>> 
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>
> Acked-by: Amit Shah <amit.shah@redhat.com>
>
> Rusty, please pick this up.

Thanks for the CC.

Applied,
Rusty.
