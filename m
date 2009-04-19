From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-balloon: check for freezer in kthread loop
Date: Sun, 19 Apr 2009 23:14:12 +0930
Message-ID: <200904192314.12953.rusty@rustcorp.com.au>
References: <20090417001404.GA20251@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090417001404.GA20251@amt.cnet>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 17 Apr 2009 09:44:04 am Marcelo Tosatti wrote:
> 
> Break out of wait_event_interruptible() if freezing has been requested,
> in the vballoon thread. Without this change vballoon refuses to stop and
> the system can't suspend.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

-stable too, yeah?

Applied,
Rusty.
