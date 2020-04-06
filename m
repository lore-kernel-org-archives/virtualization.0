From: Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH] Fix: buffer overflow during hvc_alloc().
Date: Mon, 6 Apr 2020 10:31:40 +1000
Message-ID: <a8ab8fe3-3200-9591-7572-abbbd2d505ff@linux.ibm.com>
References: <20200405204024.1007843-1-andrew@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200405204024.1007843-1-andrew@daynix.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: andrew@daynix.com, virtualization@lists.linux-foundation.org
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, jslaby@suse.com
List-Id: virtualization@lists.linuxfoundation.org

On 6/4/20 6:40 am, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
> 
> If there is a lot(more then 16) of virtio-console devices
> or virtio_console module is reloaded
> - buffers 'vtermnos' and 'cons_ops' are overflowed.
> In older kernels it overruns spinlock which leads to kernel freezing:
> https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> 

This Bugzilla report isn't publicly accessible. Can you include a 
relevant summary here and/or make the report publicly viewable?

If it does indeed lead to a kernel freeze, this should be tagged with a 
Fixes: and a Cc: stable@vger.kernel.org.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
