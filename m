From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH] virtio: make VIRTIO a menuconfig to ease disabling it all
Date: Thu, 21 Dec 2017 17:23:14 +0100
Message-ID: <CAEwRq=pVCUPGq4=JLOHQ4gQE0FC+Fotci8+DR_VupgB1BJJB1w__38042.6003867344$1513873290$gmane$org@mail.gmail.com>
References: <20171209152657.4762-1-vincent.legoll@gmail.com>
	<87tvwkfj2f.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87tvwkfj2f.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: virtualization@lists.linux-foundation.org, Linux Kernel ML <linux-kernel@vger.kernel.org>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hello,

thanks for the help, and sorry for the poor patch,

On Thu, Dec 21, 2017 at 11:53 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> This breaks all existing .configs *and* defconfigs that use VIRTIO.
>
> Please don't do that.
>
> If you make it default y then everything will continue to work.

Do you want me to respin it with the added default ?

Tchuss

-- 
Vincent Legoll
