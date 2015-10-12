From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Mon, 12 Oct 2015 16:52:50 +0300
Message-ID: <20151012135248.GB2586@rkaganb.sw.ru>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<561BB8D2.60402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <561BB8D2.60402@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Blake <eblake@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 12, 2015 at 07:42:42AM -0600, Eric Blake wrote:
> On 10/09/2015 07:39 AM, Denis V. Lunev wrote:
> > From: Andrey Smetanin <asmetanin@virtuozzo.com>
> > 
> > A new vcpu exit is introduced to notify the userspace of the
> > changes in Hyper-V synic configuraion triggered by guest writing to the
> Again, is 'synic' intended?  Hmm, I see it throughout the patch, so it
> looks intentional, but I keep trying to read it as a typo for 'sync'.

I tend to mistype it as 'cynic' as better matching what it is ;)

Note taken, we'll address that in the next round, thanks.

Roman.
