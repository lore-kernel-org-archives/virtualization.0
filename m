From: Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 13/35] drivers/char: Convert remaining use of pr_warning
	to pr_warn
Date: Fri, 17 Feb 2017 13:23:34 +0530
Message-ID: <20170217075334.GA13172__17212.8444690772$1487967474$gmane$org@grmbl.mre>
References: <cover.1487314666.git.joe@perches.com>
	<12cea829f0c93182e8775e453e411a236d529b58.1487314667.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <12cea829f0c93182e8775e453e411a236d529b58.1487314667.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 16 Feb 2017 [23:11:26], Joe Perches wrote:
> To enable eventual removal of pr_warning
> 
> This makes pr_warn use consistent for drivers/char
> 
> Prior to this patch, there were 1 use of pr_warning and
> 40 uses of pr_warn in drivers/char
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Amit Shah <amit@kernel.org>

Thanks,

		Amit
-- 
http://log.amitshah.net/
