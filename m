From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 04/16] per-cpu run guest
Date: Tue, 8 Jan 2008 22:02:27 +1100
Message-ID: <200801082202.28263.rusty__39197.8817912333$1199790299$gmane$org@rustcorp.com.au>
References: <1199711137195-git-send-email-gcosta@redhat.com>
	<11997111523234-git-send-email-gcosta@redhat.com>
	<1199711157132-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1199711157132-git-send-email-gcosta@redhat.com>
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

On Tuesday 08 January 2008 00:05:25 Glauber de Oliveira Costa wrote:
> +	/* Watch out for arbitrary vcpu indexes! */
> +	if (vcpu_id > lg->nr_vcpus)
> +		return -EINVAL;
> +
> +	vcpu = &lg->vcpus[vcpu_id];
> +

Out-by-one error here... Fixed it for you, plus a couple of others.

I've applied the patches, but made one minor-but-invasive change: I didn't 
want to ask you to spin the patches again!

I changed "vcpu" to "cpu" everywhere (the v is pretty redundant in this 
context), which cut about a dozen lines of code out (things now fitted 
again!).

I also changed "vcpu_id" to simply "id" and made it unsigned.  Do you plan for 
this to always be equal to the index in the vcpu array BTW?  If so, we can 
neaten vcpu_start (now lg_cpu_start)...

You can grab the latest now...

Thanks!
Rusty.
