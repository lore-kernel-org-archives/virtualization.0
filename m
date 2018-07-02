From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86-64: use RIP-relative calls for paravirt indirect ones
Date: Mon, 2 Jul 2018 15:53:44 +0200
Message-ID: <b6a572bb-c9d8-bf51-c1fb-ec6d19bc6360@suse.com>
References: <5B30C3F102000078001CD6F1@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5B30C3F102000078001CD6F1@suse.com>
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
To: Jan Beulich <JBeulich@suse.com>, Alok Kataria <akataria@vmware.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 25/06/18 12:29, Jan Beulich wrote:
> This saves one insn byte per instance, summing up to a savings of over
> 4k in my (stripped down) configuration. No variant of to be patched in
> replacement code relies on the one byte larger size.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
