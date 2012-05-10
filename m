From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-mmio: Devices parameter parsing
Date: Thu, 10 May 2012 10:14:55 +0930
Message-ID: <87d36cdfug.fsf@rustcorp.com.au>
References: <1336584616-7802-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1336584616-7802-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  9 May 2012 18:30:16 +0100, Pawel Moll <pawel.moll@arm.com> wrote:
> This patch adds an option to instantiate guest virtio-mmio devices
> basing on a kernel command line (or module) parameter, for example:
> 
> 	virtio_mmio.devices=0x100@0x100b0000:48
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> 
> Hi Rusty,
> 
> As the param changes are in now, could you queue this
> long-time-forgotten patch for 3.5?

Finally, thanks!

> PS. Congratulations once again and see you in HK.

Thanks, and looking forward to it!

Cheers,
Rusty. 
