From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Stop doing DMA on the stack
Date: Tue, 6 Sep 2016 12:33:43 +0530
Message-ID: <20160906070343.GD3100@amit-lp.rh>
References: <0afe68f9b4be6c95af9e7672b07acd0274c26dfe.1472569320.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0afe68f9b4be6c95af9e7672b07acd0274c26dfe.1472569320.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 30 Aug 2016 [08:04:15], Andy Lutomirski wrote:
> virtio_console uses a small DMA buffer for control requests.  Move
> that buffer into heap memory.
> 
> Doing virtio DMA on the stack is normally okay on non-DMA-API virtio
> systems (which is currently most of them), but it breaks completely
> if the stack is virtually mapped.
> 
> Tested by typing both directions using picocom aimed at /dev/hvc0.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Looks fine,

Reviewed-by: Amit Shah <amit.shah@redhat.com>

> ---
> 
> Hi all-
> 
> This is currently broken in tip:x86/asm.  If you (Amit) like this patch,
> would it make sense for Ingo to add it to -tip?

Yes, I'm fine with that.


     	 Amit
