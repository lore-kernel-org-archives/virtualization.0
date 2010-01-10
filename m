From: Dor Laor <dlaor@redhat.com>
Subject: Re: Virtio ballooning support for Lguest
Date: Sun, 10 Jan 2010 09:45:53 +0200
Message-ID: <4B4985B1.4060300@redhat.com>
References: <93e720dc1001081035t68b4fb8bracea5e5e61443b99@mail.gmail.com>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <93e720dc1001081035t68b4fb8bracea5e5e61443b99@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gaurav Kukreja <mailme.gaurav@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/08/2010 08:35 PM, Gaurav Kukreja wrote:
> Hi,
>
> I am doing working on enabling Transcendent Memory(OLS '09) support on
> lguest.
>
> For the same, I need ballooning support for lguest. Is there an
> implmentation of Virtio Balloon driver, that I can use for my purpose?

driver: http://lxr.linux.no/#linux+v2.6.32/drivers/virtio/virtio_balloon.c

device: http://git.savannah.gnu.org/cgit/qemu.git/tree/hw/virtio-balloon.c


>
> Could someone give me an insight, as to how to go about, for
> implementing this myself, incase I dont find this patch...
>
> Thankyou.
>
> --
> Gaurav Kukreja
>
> +91 997 030 1257
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
