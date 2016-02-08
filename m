From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/6] VMware balloon: Update vmw_balloon.c to use the
	VMW_PORT macro
Date: Mon, 8 Feb 2016 11:41:57 -0800
Message-ID: <20160208194157.GA10802@kroah.com>
References: <1449271183-1746-1-git-send-email-syeh@vmware.com>
	<1453239965-1466-1-git-send-email-syeh@vmware.com>
	<1453239965-1466-7-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1453239965-1466-7-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: pv-drivers@vmware.com, Xavier Deguillard <xdeguillard@vmware.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 19, 2016 at 01:46:05PM -0800, Sinclair Yeh wrote:
> Updated VMWARE_BALLOON_CMD to use the common VMW_PORT macro.
> Doing this rather than replacing all instances of VMWARE_BALLOON_CMD
> to minimize code change.
> 
> Signed-off-by: Sinclair Yeh <syeh@vmware.com>
> Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Alok N Kataria <akataria@vmware.com>
> Acked-by: Xavier Deguillard <xdeguillard@vmware.com>
> Cc: pv-drivers@vmware.com
> Cc: Xavier Deguillard <xdeguillard@vmware.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> -#define VMWARE_BALLOON_CMD(cmd, arg1, arg2, result)		\
> -({								\
> -	unsigned long __status, __dummy1, __dummy2, __dummy3;	\
> -	__asm__ __volatile__ ("inl %%dx" :			\
> -		"=a"(__status),					\
> -		"=c"(__dummy1),					\
> -		"=d"(__dummy2),					\
> -		"=b"(result),					\
> -		"=S" (__dummy3) :				\
> -		"0"(VMW_BALLOON_HV_MAGIC),			\
> -		"1"(VMW_BALLOON_CMD_##cmd),			\
> -		"2"(VMW_BALLOON_HV_PORT),			\
> -		"3"(arg1),					\
> -		"4" (arg2) :					\
> -		"memory");					\
> -	if (VMW_BALLOON_CMD_##cmd == VMW_BALLOON_CMD_START)	\
> -		result = __dummy1;				\
> -	result &= -1UL;						\
> -	__status & -1UL;					\
> +#define VMWARE_BALLOON_CMD(cmd, arg1, arg2, result)			\
> +({									\
> +	unsigned long __status, __dummy1, __dummy2;			\
> +	unsigned long __si, __di;					\
> +	VMW_PORT(VMW_BALLOON_CMD_##cmd, arg1, arg2, 0,			\
> +		 VMW_BALLOON_HV_PORT, VMW_BALLOON_HV_MAGIC,		\
> +		 __status, result, __dummy1, __dummy2, __si, __di);	\
> +	if (VMW_BALLOON_CMD_##cmd == VMW_BALLOON_CMD_START)		\
> +		result = __dummy1;					\
> +	result &= -1UL;							\
> +	__status & -1UL;						\
>  })

Honestly, it doesn't look anymore "readable" to me, but it's your code
to maintain, not mine... :)
