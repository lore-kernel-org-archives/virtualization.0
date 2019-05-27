From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v7 11/12] x86/paravirt: Adapt assembly for PIE support
Date: Mon, 27 May 2019 07:47:10 +0200
Message-ID: <1b53b8eb-5dd3-fb57-d8db-06eedd0ce49f__46701.8167766341$1558936067$gmane$org@suse.com>
References: <20190520231948.49693-1-thgarnie@chromium.org>
	<20190520231948.49693-12-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190520231948.49693-12-thgarnie@chromium.org>
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
To: Thomas Garnier <thgarnie@chromium.org>, kernel-hardening@lists.openwall.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Garnier <thgarnie@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, kristen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 21/05/2019 01:19, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> if PIE is enabled, switch the paravirt assembly constraints to be
> compatible. The %c/i constrains generate smaller code so is kept by
> default.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
