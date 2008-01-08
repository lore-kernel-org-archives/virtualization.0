From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [kvm-devel] [PATCH] QEMU KVM balloon support
Date: Tue, 8 Jan 2008 16:43:42 +0000
Message-ID: <20080108164342.GF21294__32485.8999964365$1199824827$gmane$org@redhat.com>
References: <20080108154340.GC21726@dmt>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080108154340.GC21726@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2008 at 01:43:40PM -0200, Marcelo Tosatti wrote:
> Index: kvm-userspace/qemu/monitor.c
> ===================================================================
> --- kvm-userspace.orig/qemu/monitor.c
> +++ kvm-userspace/qemu/monitor.c
> @@ -1339,6 +1339,8 @@ static term_cmd_t term_cmds[] = {
>        "", "cancel the current VM migration" },
>      { "migrate_set_speed", "s", do_migrate_set_speed,
>        "value", "set maximum speed (in bytes) for migrations" },
> +    { "setmem", "s", do_setmemory, "value", 
> +      "set memory for the guest (in bytes)" },
>      { NULL, NULL, },
>  };

[snip]

> +void do_setmemory(const char *value)
> +{
> +	int target_ramsize;
> +	char *ptr;
> +
> +	target_ramsize = strtol(value, &ptr, 10);
> +	switch (*ptr) {
> +	case 'G': case 'g':
> +		target_ramsize *= 1024;
> +	case 'M': case 'm':
> +		target_ramsize *= 1024;
> +	case 'K': case 'k':
> +		target_ramsize *= 1024;
> +	default:
> +		break;
> +	}
> +
> +	if (target_ramsize > ram_size) {
> +		term_printf("Invalid RAM size, maximum: %d\n", ram_size);
> +		return;
> +	}
> +	
> +	balloon_update_target(target_ramsize);
> +}

Shouldn't this use  int64, and strtoll(), otherwise you'll wrap
at the 2 GB mark ?

Regards,
Dan.
-- 
|=- Red Hat, Engineering, Emerging Technologies, Boston.  +1 978 392 2496 -=|
|=-           Perl modules: http://search.cpan.org/~danberr/              -=|
|=-               Projects: http://freshmeat.net/~danielpb/               -=|
|=-  GnuPG: 7D3B9505   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505  -=| 
