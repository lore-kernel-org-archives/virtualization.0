From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v9 01/84] signal: export kill_pid_info()
Date: Wed, 22 Jul 2020 07:36:35 +0100
Message-ID: <20200722063635.GA20491@infradead.org>
References: <20200721210922.7646-1-alazar@bitdefender.com>
 <20200721210922.7646-2-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721210922.7646-2-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: Adalbert Laz??r <alazar@bitdefender.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 22, 2020 at 12:07:59AM +0300, Adalbert Laz??r wrote:
> From: Mathieu Tarral <mathieu.tarral@protonmail.com>
> 
> This function is used by VM introspection code to ungracefully shutdown
> a guest at the request of the introspection tool.
> 
> A security application will use this as the last resort to stop the
> spread of a malware from a guest.

I don't think your module has any business doing this.  If at all
it would be an EXPORT_SYMBOL_GPL, but the export is very questionable
and needs a much better justification.
