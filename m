From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio-scsi spec: add configuration change event
Date: Tue, 17 Jul 2012 09:51:56 +0930
Message-ID: <874np7xmmz.fsf@rustcorp.com.au>
References: <1342448677-7453-1-git-send-email-pbonzini@redhat.com>
	<1342448677-7453-3-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342448677-7453-3-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 16 Jul 2012 16:24:37 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This adds an event for changes to LUN parameters, for example capacity.  These
> are reported in virtio-blk via configuration changes, and we want a similar
> functionality in virtio-scsi too.

Both applied.

Thanks!
Rusty.
