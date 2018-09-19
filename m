From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: fix some warning messages
Date: Wed, 19 Sep 2018 12:47:06 +0200
Message-ID: <4d2ee859-12de-df78-0a50-2dc8e6c1e77d@suse.com>
References: <20180919103553.GD9238@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180919103553.GD9238@mwanda>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 19/09/18 12:35, Dan Carpenter wrote:
> The first argument to WARN_ONCE() is a condition.
> 
> Fixes: 5800dc5c19f3 ("x86/paravirt: Fix spectre-v2 mitigations for paravirt guests")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
