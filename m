From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 01/16] introduce vcpu struct
Date: Wed, 26 Dec 2007 10:34:05 +1100
Message-ID: <200712261034.06419.rusty__3.41912168568825$1198625772$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576442148-git-send-email-gcosta@redhat.com>
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
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 December 2007 00:33:41 Glauber de Oliveira Costa wrote:
> this patch introduces a vcpu struct for lguest. In upcoming patches,
> more and more fields will be moved from the lguest struct to the vcpu

Hi Glommer,

> +static inline struct lguest *lg_of_vcpu(struct lguest_vcpu *vcpu)
> +{
> +	return container_of((vcpu - vcpu->vcpu_id), struct lguest, vcpus[0]);
> +}

I think this function is a bad idea: it contains implicit UP assumptions which 
aren't obvious to the caller.  vcpu->lg should do the same thing, no?

Rusty,
