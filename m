From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [edk2] QueuePFN peculiarity in virtio-mmio
Date: Tue, 22 Oct 2013 20:05:43 +0200
Message-ID: <5266BE77.40007@redhat.com>
References: <5266BAA1.5080303@redhat.com> <5266BC08.6070008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5266BC08.6070008@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: edk2-devel@lists.sourceforge.net
Cc: Jon Masters <jcm@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Liguori <anthony@codemonkey.ws>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 10/22/13 19:55, Laszlo Ersek wrote:

>> The question arises because Olivier has posted a series to edk2-devel
>> that adds virtio-mmio support to TianoCore, and Mark tested it (using
>> OVMF) with a Linux guest and found problems. Namely, OVMF itself can
>> drive the virtio devices via virtio-mmio, but the Linux kernel booted
>> from OVMF can not. The reason is the missing zeroing of QueuePFN when
>> OVMF is exiting. (I'm just paraphrasing the analysis.)

s/OVMF/AArch64 foundation model/g

http://thread.gmane.org/gmane.comp.bios.tianocore.devel/4373/focus=4411


I should have followed my own advice, not to post when sick. I'll go now
and hide in a cave.

Laszlo
/facepalm
