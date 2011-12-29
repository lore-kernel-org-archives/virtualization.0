From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
Date: Thu, 29 Dec 2011 08:53:48 +0200
Message-ID: <CAK=WgbZzhFS3tTpywN2HUdjmpTuWSqg9BCC9=QaO10=d_ACRiA@mail.gmail.com>
References: <8739cbkgv2.fsf@rustcorp.com.au>
	<CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
	<CA+55aFzKU0GWqpQo2AzAawoVm=qPaJiwKTcifeYApyZP_Hj3nQ@mail.gmail.com>
	<CAK=WgbacH1tXHJiHNKLNNsFA7-vnFT_J6vYOANh0wzGyUj8Zpg@mail.gmail.com>
	<87y5twf16x.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87y5twf16x.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 29, 2011 at 6:31 AM, Rusty Russell <rusty@rustcorp.com.au> wrot=
e:
> OK, I've applied this patch; you might want to carry it in your tree
> too. =A0You'll need to fix up your call to vring_new_virtqueue()....

Will do. Thanks !
